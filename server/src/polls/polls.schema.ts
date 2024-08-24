import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema({ timestamps: true })
export class Poll extends Document {
  @Prop({ required: true })
  price: number;

  @Prop({ required: true })
  content: string;

  @Prop({ required: true })
  thumbnail: string;

  @Prop({ required: true })
  coupangUrl: string;

  @Prop({ required: true, default: [] })
  likes: string[];

  @Prop({ required: true, default: [] })
  dislikes: string[];

  @Prop({ required: true, default: [] })
  comments: { userId: string, name: string, content: string }[];

  @Prop()
  createdAt: Date;

  @Prop()
  updatedAt: Date;
}

export const PollSchema = SchemaFactory.createForClass(Poll);
