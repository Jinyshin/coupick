import { Controller, Get, Headers, Param, Post } from '@nestjs/common';
import { PollsService } from './polls.service';

@Controller('polls')
export class PollsController {
  constructor(
    private readonly pollsService: PollsService
  ) {}

  @Get()
  async listPolls(@Headers('Authorization') token?: string) {
    // const { userId } = this.jwtService.verify(authorization);
    // return userId;
    return this.pollsService.auth(token);
    const polls = await this.pollsService.listPolls('');
  }

  @Post()
  async createPoll() {}

  @Post(':pollId/likes')
  async likePoll(@Param('pollId') pollId: string) {}
}
