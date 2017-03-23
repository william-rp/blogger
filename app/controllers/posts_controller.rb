class PostsController < ApplicationController
    before_filter :authenticate_user!, only: [:new, :create]

def new
    @post = Post.new
end

def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save!
        redirect_to @post
    else
        render :new
    end
end

def edit
    @post = Post.find(params[:id])
end

def update
    @post = Post.find(params[:id])
    @post.update post_params
    if @post.save!
        redirect_to @post
    else
        render :edit
    end
end

def index
    @posts = Post.all
end

def edit
    @post = Post.find(params[:id])
end

def show
    @post = Post.find(params[:id])
    @comment = Comment.new
end

def comments
    @post = Post.find(params[:id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save!
        redirect_to @post
    else
        render :@post
    end
end
   
   
    
end


    private 
        def post_params
             params.require(:post).permit(:title, :body, :published)
        end
        
        def comment_params
                params.require(:comment).permit(:body)
        end