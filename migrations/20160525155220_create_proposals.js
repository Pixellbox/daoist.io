exports.up = function(knex, Promise) {
  return knex.schema.createTable('proposals', function(t) {
    t.increments('id');
    t.string('title').notNullable().index();
    t.string('slug').index()
    t.string('name').notNullable().index();
    t.string('email').notNullable().index();
    t.string('url');
    t.text('outline');
    t.string('full_title');
    t.string('organization');
    t.string('funding');
    t.integer('days_left');
    t.float('vote').defaultTo(0);
    t.float('vote_needed');
    t.string('inkpad');
    t.timestamps();
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.dropTable('proposals');
};
