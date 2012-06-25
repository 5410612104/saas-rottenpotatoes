
require 'spec_helper'

describe MoviesController do

	before :each do
		@fake_movie = stub('double').as_null_object
		@fake_movie.stub(:director).and_return('fake director')
		@movie = [mock('movie1')]
	end

	describe 'updating movie info' do
		before :each do
			movie_id = 5
			Movie.should_receive(:find).with(movie_id.to_s).and_return(@fake_movie)
			@fake_movie.should_receive(:update_attributes!).exactly 1
			post :update, {:id => movie_id, :movie => @movie}
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
		before :each do
			@movie_id = 10
			@founded = [mock('a movie'), mock('another one')]
		end
		it 'should render same_director view' do
			Movie.stub(:find).and_return(@fake_movie)
			Movie.stub(:find_all_by_director).and_return(@founded)

			get :same_director, {:id => @movie_id}
			response.should render_template 'same_director'
		end
		it 'should call Model method to get movies with same director' do
			Movie.should_receive(:find).with(@movie_id.to_s).and_return(@fake_movie)
			Movie.should_receive(:find_all_by_director).and_return(@founded)

			get :same_director, {:id => @movie_id}
		end
		it 'should make founded movies available to the view' do
			Movie.stub(:find).and_return(@fake_movie)
			Movie.stub(:find_all_by_director).and_return(@founded)

			get :same_director, {:id => @movie_id}

			assigns(:movies).should == @founded
		end
		it 'should return to home page, if no movies founded' do
			empty_director =  double('movie', :director => '').as_null_object
			Movie.stub(:find).and_return(empty_director)
			Movie.stub(:find_all_by_director)
			
			get :same_director, {:id => @movie_id}
			response.should redirect_to(movies_path)						
		end
	end

end
