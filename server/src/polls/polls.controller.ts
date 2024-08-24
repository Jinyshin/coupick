import { Controller, Get, Headers, Param, Post } from '@nestjs/common';
import { PollsService } from './polls.service';
import { JwtService } from '@nestjs/jwt';

@Controller('polls')
export class PollsController {
  constructor(
    private readonly jwtService: JwtService,
    private readonly pollsService: PollsService
  ) {}

  @Get()
  async listPolls(@Headers('Authorization') authorization?: string) {
    const { userId } = this.jwtService.verify(authorization);
    return userId;
    const polls = await this.pollsService.listPolls('');
  }

  @Post()
  async createPoll() {}

  @Post(':pollId/likes')
  async likePoll(@Param('pollId') pollId: string) {}
}
