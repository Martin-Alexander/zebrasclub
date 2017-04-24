class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
    if session[:package_items] && current_user && session[:package_items].any? { |i| i["cart"] }
      OrderItem.joins(:order).where("orders.user_id = ?", current_user.id).destroy_all
      session[:package_items].each do |i|
        OrderItem.create(
          order_id: current_user.orders.last.id,
          item_id: i["item_id"],
          package: i["package"],
          cart: i["cart"],
          size: i["size"],
          quantity: i["quantity"]
        )
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    # LOL
    # x = session[:package_items]
    super
    # session[:package_items] = x
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
