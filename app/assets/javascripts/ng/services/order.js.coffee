angular
  .module 'lunchie'
  .factory 'Order', ($resource) ->
    $resource "api/orders/:id", { id: '@id' }
