exports.up = function(knex, Promise) {
  return knex.schema.table('proposals', function(t) {
    t.dropColumn('full_title');
    t.dropColumn('organization');
    t.dropColumn('funding');
    t.dropColumn('days_left');
    t.dropColumn('vote');
    t.dropColumn('vote_needed');
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.table('proposals', function(t) {
    t.string('full_title');
    t.string('organization');
    t.string('funding');
    t.integer('days_left');
    t.float('vote').defaultTo(0);
    t.float('vote_needed');
  });
};
