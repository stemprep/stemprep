(function () {
  var SearchModule = {
      init: function () {
        this.getElements();
        this.bindElements();
        console.log("search js ready");
      },
      getElements: function () {
        this.$searchForm = $("#search-form");
        this.$resultTag = $("#search-results");
        this.$searchPath = this.$searchForm.attr('action');
      },
      bindElements: function () {
        var self = this;
        this.$searchForm.on('submit', function (event) {
          event.preventDefault();
          self.searchUsers($("#query").val());
        });
      },
      searchUsers: function(searchParam) {
        console.log("forum post clicked");
        var self = this;
        $.ajax({
          url: self.$searchPath,
          method: 'get',
          data: {ajax: true, query: searchParam}
        })
        .done(function(response) {
          var resultsTemplate = response;
          self.$resultTag.prepend(resultsTemplate);
        });
      }
    };
  SearchModule.init();
})();
