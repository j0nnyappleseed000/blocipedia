class WikisController < ApplicationController
   def new
    @wiki = Wiki.new
   end
 end