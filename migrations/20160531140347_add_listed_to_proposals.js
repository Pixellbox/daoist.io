exports.up = function(knex, Promise) {
  return knex.schema.table('proposals', function(t) {
    t.boolean('listed').default(true);
  });
};

exports.down = function(knex, Promise) {
  return knex.schema.table('proposals', function(t) {
    t.dropColumn('listed');
  });
};
