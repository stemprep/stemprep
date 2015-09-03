
(function() {
  var ForumModule = {
    init: function () {
      this.getElements();
      this.bindElements();
      console.log("forum js ready");
    },
    getElements: function () {
      this.$forumTitle = $(".forum-post-link");
      this.$forumLink = this.$forumTitle.attr('id');
      this.$noScrollElement = $(".content-wrap");
      this.$appendElement = $(".attachPost");
    },
    bindElements: function () {
      var self = this;
      this.$forumTitle.on('click', function (event) {
        event.preventDefault();
        self.showPost($(this).attr('id'));
      });
    },
    showPost: function(postId) {
      console.log("forum post clicked");
      var self = this;
      self.unBindListeners(self.$forumTitle);
      self.window = window;
      self.paramId = postId;
      $.ajax({
        url: self.paramId,
        method: 'get',
        data: {ajax: true}
      })
      .done(function(response) {
        var postTemplate = response;
        self.$noScrollElement.addClass('stop-scroll');
        self.$appendElement.after(postTemplate);
        $("#forum-modal").css({display:'block', opacity:'1'});
        window.history.pushState({'post_id': self.paramId}, "", self.paramId);
        CommentModule.init();
        debugger
      });
    },
    unBindListeners: function (bindedElement) {
      bindedElement.off("click");
    }
  };

  var CommentModule = {
    init: function () {
      this.getElements();
      this.bindElements();
      console.log("comment module initialized");
    },
    getElements: function () {
      this.$postRoute = $("#comment-form").attr('action');
      this.$commentBody = $("#comment-body");
      this.$appendTag = $(".replies-header");
      this.$userId = $("#comment-user").attr('value');
      this.$postId = $("#comment-post").attr('value');
      this.$submitButton = $("#submit-comment");
    },
    bindElements: function () {
      this.$submitButton.on('click', this.postComment.bind(this));
    },
    postComment: function () {
      var self = this;
      this.$submitButton.off();
      console.log("clicked");
      $.ajax({
        url: self.$postRoute,
        method: 'post',
        data: {
          comment: {
            user_id: self.$userId,
            post_id: self.$postId,
            body: $("#comment-body").val()
          }
        }
      })
      .done(function(response) {
        console.log("success");
        debugger
        var newComment = response;
        self.$appendTag.after(newComment).toggle();
        newComment.slideToggle('slow');
        self.bindElements();
      });
    }
  };

  if (window.location.pathname.includes('posts')) {
    var urlArray = window.location.pathname.split('/');
    ForumModule.init();
    ForumModule.showPost(urlArray.pop());
  } else {
    ForumModule.init();
  };


})();
