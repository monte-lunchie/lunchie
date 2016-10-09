angular
  .module 'lunchie'
  .controller 'OrderNewCtrl', ($scope, $timeout, $q, $mdToast, $mdDialog, Order, Restaurant) ->
    $parent = $scope.$parent;
    $scope.restaurants = Restaurant.query()
    $scope.order = {}

    $scope.clearForms = ->
      $scope.restaurantSearchTerm = ''
      $scope.restaurantSelected = null
      $scope.mealSearchTerm = ''
      $scope.mealSelected = null
      $scope.mealPrice = 0.0

    $scope.filterRestaurants = (searchTerm) ->
      deferred = $q.defer()
      if searchTerm
        results = $scope.restaurants.filter($parent.createSimpleFilter(searchTerm))
        results.push { id: null, name: searchTerm } if results.length == 0
      else
        results = $scope.restaurants

      deferred.resolve(results)
      deferred.promise

    $scope.filterMeals = (searchTerm) ->
      deferred = $q.defer()
      if searchTerm && $scope.restaurantSelected && $scope.restaurantSelected.hasOwnProperty('meals')
        results = $scope.restaurantSelected.meals.filter($parent.createSimpleFilter(searchTerm))
        results.push { id: null, name: searchTerm } if results.length == 0
      else
        results = [{ id: null, name: searchTerm }]

      deferred.resolve(results)
      deferred.promise

    $scope.showNewMealDialog = ($event)->
      if $scope.restaurantSelected == null
        $parent.showToastMessage 'No restaurant name provided!'
      else
        $scope.mealSearchTerm = ''
        $scope.mealSelected = null
        $scope.mealPrice = 0.0
        $mdDialog.show
          templateUrl: 'meals/new.html'
          escapeToClose: true
          clickOutsideToClose: true
          openFrom: $event.target
          closeTo: $event.target
          scope: $scope
          preserveScope: true

    $scope.addOrder = ->
      if $scope.restaurantSelected == null
        $parent.showToastMessage 'No restaurant name provided!'
      else if $scope.mealSelected == null
        $parent.showToastMessage 'No meal provided!'
      else if $scope.mealPrice < 0
        $parent.showToastMessage 'No price provided!'
      else
        order = new Order
          order:
            creator_id: $scope.user.id
            restaurant_attributes:
              id: $scope.restaurantSelected.id
              name: $scope.restaurantSelected.name
            user_orders_attributes:
              '0':
                meal_attributes:
                  id: $scope.mealSelected.id
                  name: $scope.mealSelected.name
                  price: $scope.mealPrice

        order.$save (user, response) ->
          $scope.clearForms()
          $mdDialog.hide()
          $parent.showToastMessage 'Order created!'

    return
