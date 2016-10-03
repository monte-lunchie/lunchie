angular
  .module 'lunchie'
  .factory 'Restaurant', ($resource) ->
    $resource "api/restaurants/:id", { id: '@id' }
