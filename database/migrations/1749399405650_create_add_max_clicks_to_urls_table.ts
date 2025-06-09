import { BaseSchema } from '@adonisjs/lucid/schema'

export default class extends BaseSchema {
  protected tableName = 'add_max_clicks_to_urls'

  async up() {
    this.schema.alterTable('urls', (table) => {
      table.integer('max_clicks').nullable()
    })
  }

  async down() {
    this.schema.alterTable('urls', (table) => {
      table.dropColumn('max_clicks')
    })
  }
}
