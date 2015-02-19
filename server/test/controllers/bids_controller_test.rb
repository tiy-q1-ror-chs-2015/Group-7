require 'test_helper'

class BidsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test '#index' do
    get :index, format: :json
    assert_equal response.code, '200'
    results = JSON.parse(response.body)

    refute_empty results
    assert results.first['amount'].present?
  end

  test '#create' do
    test_attributes = {
      amount: '100',
      bidder: 'Adam',
      auction_id: Auction.first.id
    }

    assert_difference 'Bid.count' do
      post :create, format: :json, bid: test_attributes
    end

    assert_equal response.code, '200'
  end

  test '#update' do
    foo = bids(:first_bid)
    bar = foo.amount
    params = {:id => foo.id, :amount => "foodoo"}
    put :update, format: :json, bid: params, id: foo.id
    assert_equal response.code, '200'
  end

  test '#destroy' do
    foo = Bid.first
    params = {id: foo.id}
    assert_difference 'Bid.count', -1 do
      delete :destroy, format: :json, id: foo.id
    end
  end
end











