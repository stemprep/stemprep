(function() {
  var CommentModule = {
    init: function () {
      this.getElements();
      this.bindElements();
    },
    getElements: function () {
      this.$postRoute = $("#comment-form").attr('action');
      this.$commentBody = $("#comment-body");
      this.$userId = $("#comment-user");
      this.$postId = $("#comment-post");
      this.$submitButton = $("#submit-comment");
    },
    bindElements: function () {
      var self = this;
      this.$submitButton.on('click', function(event) {
        event.preventDefault();
        self.postComment();
      });
    },
    postComment: function () {
      var self = this;
      $.ajax({
        url: this.$postRoute,
        type: 'POST',
        data: {
          comment: {
            'user_id': this.$userId,
            'post_id': this.$postId,
            'body': this.$commentBody.val()
          }
      },
      })
      .done(function() {
        console.log("success");
      })
      .fail(function() {
        console.log("error");
      })
      .always(function() {
        console.log("complete");
      });

    }
  };

  CommentModule.init();

})();
