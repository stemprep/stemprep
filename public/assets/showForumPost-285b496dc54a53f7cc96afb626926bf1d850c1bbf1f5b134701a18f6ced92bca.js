
(function() {
  var ForumModule = {
    init: function () {
      this.getElements();
      this.bindElements();
      this.checkSidebar();
      console.log("forum js ready");
    },
    getElements: function () {
      this.$forumTitle = $(".forum-post-link");
      this.$forumLink = this.$forumTitle.attr('id');
      this.$noScrollElement = $(".content-wrap");
      this.$appendElement = $(".attachPost");
    },
    checkSidebar:function  () {
      // debugger
      setTimeout(function(){
        if(!$("body").attr('class')){
          window.SingApp.toggleNavigationCollapseState();
        }
      }, 2800);
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
        self.bindCloseButton();
        CommentModule.init();
      });
    },
    bindCloseButton: function () {
      var self = this;
      $("#close-post").on('click', function(event) {
        event.preventDefault();
        window.history.pushState({'post_id': ''}, "", '/forum');
        $("#animate-post-modal").css({
          animation: '.2s dismissModal ease',
          'animation-fill-mode': 'forwards'
        });
        $(".modal-backdrop.fade").fadeToggle('slow', function() {
          self.$noScrollElement.removeClass('stop-scroll');
          $("#close-post").off();
          $(".modal-backdrop.fade").remove();
          $("#forum-modal").remove();
          self.bindElements();
        });
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
    redirectPath: function () {
      window.location = this.$postId;
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
        self.redirectPath();
        console.log("success");
        // self.$appendTag.after(response.template);
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

// nav-collapsed
