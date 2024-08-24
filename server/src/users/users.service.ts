import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { User } from './users.schema';
import { Model } from 'mongoose';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class UsersService {
  constructor(private readonly jwtService: JwtService, @InjectModel(User.name) private userModel: Model<User>) {}

  async createUser(name: string) {
    const user = await this.userModel.create({ name });

    return await this.jwtService.sign(user);
  }
}
