import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Poll } from './polls.schema';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { User } from 'src/users/users.schema';

@Injectable()
export class PollsService {
  constructor(
    private readonly jwtService: JwtService,
    @InjectModel(Poll.name) private pollModel: Model<Poll>
  ) {}

  auth(token: string) {
    return this.jwtService.verify(token.substring(7)) as User;
  }

  async listPolls(userId: string) {
    // return await this.pollModel.find({
    //   likers: { $nin: [ userId ] },
    //   dislikers: { $nin: [ userId ] }
    // });

    return await this.pollModel.aggregate([
      {
        $match: {
          likers: { $nin: [ userId ] },
          dislikers: { $nin: [ userId ] }
        }
      },
      {
        $sample: { size: 20 }
      }
    ]) as Poll[];
  }
}
