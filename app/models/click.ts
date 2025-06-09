import { DateTime } from 'luxon'
import { BaseModel, column, belongsTo } from '@adonisjs/lucid/orm'
import type { BelongsTo } from '@adonisjs/lucid/types/relations'
import Url from './url.js'
export default class Click extends BaseModel {
  @column()
  declare urlId: number

  @column()
  declare ipAddress: string

  @column()
  declare userAgent: string | null

  @column.dateTime()
  declare clickedAt: DateTime

  @column()
  declare description: string | null

  @belongsTo(() => Url)
  declare url: BelongsTo<typeof Url>
}
