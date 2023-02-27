# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_27_080438) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.text "photo", default: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.needpix.com%2Fphoto%2Fdownload%2F178617%2Frace-car-logo-symbol-speed-coupe-speedy-car-auto-race&psig=AOvVaw3fXJ7bfq_fA43CsizkifQC&ust=1677571596590000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCKit5Kuftf0CFQAAAAAdAAAAABAJ"
    t.boolean "reserved", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
