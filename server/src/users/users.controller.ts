import { BadRequestException, Body, Controller, Delete, Post } from '@nestjs/common';
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

  @Delete()
  async deleteUserAll() {
    await this.usersService.deleteUserAll();
    return { status: 'success' };
  }

  @Post('dummy')
  async dummy() {
    const indices = [...Array(10).keys()];
    return Promise.all(indices.map((i) => this.createUser(`user-${i}`)))
  }
}
