angular
  .module 'lunchie'
  .factory 'Order', ($resource) ->
    $resource "orders/:id", { id: '@id' }
