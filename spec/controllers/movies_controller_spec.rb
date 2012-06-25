
require 'spec_helper'

describe MoviesController do

	before :each do
		@fake_movie = stub('double').as_null_object
		@movie = [mock('movie1')]
	end

	describe 'updating movie info' do
		before :each do
			Movie.should_receive(:find).with("1").and_return(@fake_movie)
			@fake_movie.should_receive(:update_attributes!).exactly 1
			post :update, {:id => 1, :movie => @movie}
		end
		it 'should call the model method that performs the movie update' do
			true
		end
		it 'should redirect to details template for rendering' do
			response.should redirect_to(movie_path @fake_movie)
		end
		it 'should make updated info available to template' do
			assigns(:movie).should == @fake_movie
		end
	end

	describe 'finding movies by same director' do
		pending "---- implement ----"
	end

end
