import { Controller, Get, Headers, Param, Post } from '@nestjs/common';
import { PollsService } from './polls.service';

@Controller('polls')
export class PollsController {
  constructor(
    private readonly pollsService: PollsService
  ) {}

  @Get()
  async listPolls(@Headers('Authorization') token?: string) {
    const { _id } = this.pollsService.auth(token);
    const polls = await this.pollsService.listPolls(_id as string);

    return polls.map(({
      likers,
      dislikers,
      comments,
      ...others
    }) => ({
      ...others,
      likes: likers.length,
      dislikes: dislikers.length,
      isVoted: [...likers, ...dislikers].includes(_id as string),
      isLiked: likers.includes(_id as string),
      isDisliked: dislikers.includes(_id as string),
      comments: comments.map(({ name, content }) => ({ name, content }))
    }))
  }

  @Post()
  async createPoll() {}

  @Post(':pollId/likes')
  async likePoll(@Param('pollId') pollId: string) {}
}
