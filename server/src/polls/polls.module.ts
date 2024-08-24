import { Module } from '@nestjs/common';
import { PollsService } from './polls.service';
import { PollsController } from './polls.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Poll, PollSchema } from './polls.schema';
import { JwtService } from '@nestjs/jwt';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Poll.name, schema: PollSchema }
    ])
  ],
  providers: [PollsService, JwtService],
  controllers: [PollsController]
})
export class PollsModule {}
