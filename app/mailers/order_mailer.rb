class OrderMailer < ApplicationMailer
  default from: 'Li Xin <xin.li@wright.com.sg>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received(line_items, user)
    @sale_transaction_line_items = line_items
    @user = user
    mail to: @user[:email], subject: 'Order confirmation'  do |format|
      format.text
    end
  end
end
