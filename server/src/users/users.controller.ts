import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  async createUser(@Body('name') name?: string) {
    if (!name) {
      throw new BadRequestException();
    }

    const token = await this.usersService.createUser(name);

    return { accessToken: token };
  }
}
