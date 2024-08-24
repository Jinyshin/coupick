import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Poll } from './polls.schema';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';

@Injectable()
export class PollsService {
  constructor(
    private readonly jwtService: JwtService,
    @InjectModel(Poll.name) private pollModel: Model<Poll>
  ) {}

  auth(token: string) {
    const { userId } = this.jwtService.verify(token);

    return userId;
  }

  async listPolls(userId: string) {
    return await this.pollModel.find({
      likers: { $nin: [ userId ] },
      dislikers: { $nin: [ userId ] }
    });
  }
}
