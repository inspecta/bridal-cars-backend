class AddDefaultCarValues < ActiveRecord::Migration[7.0]
  def change
    change_column_default :cars, :reserved, false
    change_column_default :cars, :photo, "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.needpix.com%2Fphoto%2Fdownload%2F178617%2Frace-car-logo-symbol-speed-coupe-speedy-car-auto-race&psig=AOvVaw3fXJ7bfq_fA43CsizkifQC&ust=1677571596590000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCKit5Kuftf0CFQAAAAAdAAAAABAJ"
  end
end
