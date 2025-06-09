import { DateTime } from 'luxon'
import { BaseModel, column, hasMany } from '@adonisjs/lucid/orm'
import type { HasMany } from '@adonisjs/lucid/types/relations'
import Click from './click.js'

export default class Url extends BaseModel {
  @column({ isPrimary: true })
  declare id: number

  @column()
  declare originalUrl: string

  @column()
  declare shortCode: string

  @column()
  declare userId: number | null | undefined

  @column()
  declare maxClicks: number | null | undefined

  @column.dateTime()
  declare expiresAt: DateTime | null

  @hasMany(() => Click)
  declare clicks: HasMany<typeof Click>
}
