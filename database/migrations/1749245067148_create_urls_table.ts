import { BaseSchema } from '@adonisjs/lucid/schema'

export default class extends BaseSchema {
  protected tableName = 'urls'

  async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id')
      table.string('original_url')
      table.string('short_code').unique()
      table.timestamp('expires_at', { useTz: true }).nullable()
      table.integer('clicks').defaultTo(0)
      table.integer('user_id').unsigned().references('id').inTable('users').onDelete('CASCADE')

      // ✅ CORRECTION ICI
      table.timestamp('created_at', { useTz: true }).notNullable().defaultTo(this.now())
      table.timestamp('updated_at', { useTz: true }).notNullable().defaultTo(this.now())
    })
  }

  async down() {
    this.schema.dropTable(this.tableName)
  }
}
