import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Poll } from './polls.schema';
import { Model } from 'mongoose';

@Injectable()
export class PollsService {
  constructor(
    private readonly jwtService: JwtService,
    private pollModel: Model<Poll>
  ) {}

  async listPolls(userId: string) {
    return await this.pollModel.find({
      likers: { $nin: [ userId ] },
      dislikers: { $nin: [ userId ] }
    });
  }
}
