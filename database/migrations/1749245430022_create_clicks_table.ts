import { BaseSchema } from '@adonisjs/lucid/schema'

export default class extends BaseSchema {
  protected tableName = 'clicks'

  async up() {
    this.schema.createTable(this.tableName, (table) => {
      table.increments('id') // ✅ Ajout d’un ID unique
      table.integer('url_id').unsigned().references('id').inTable('urls').onDelete('CASCADE')

      table.string('ip_address')
      table.text('user_agent').nullable()
      table.timestamp('clicked_at', { useTz: true }).notNullable().defaultTo(this.now())
      table.text('description').nullable()

      table.timestamp('created_at', { useTz: true }).notNullable().defaultTo(this.now())
      table.timestamp('updated_at', { useTz: true }).notNullable().defaultTo(this.now())
    })
  }

  async down() {
    this.schema.dropTable(this.tableName)
  }
}
