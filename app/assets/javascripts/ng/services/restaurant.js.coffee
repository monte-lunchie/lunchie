angular
  .module 'lunchie'
  .factory 'Restaurant', ($resource) ->
    $resource "restaurants/:id", { id: '@id' }
