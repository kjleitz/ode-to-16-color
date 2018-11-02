# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_26_034216) do

  create_table "animation_votes", force: :cascade do |t|
    t.integer "value"
    t.integer "user_id"
    t.integer "animation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animation_id"], name: "index_animation_votes_on_animation_id"
    t.index ["user_id"], name: "index_animation_votes_on_user_id"
  end

  create_table "animations", force: :cascade do |t|
    t.integer "user_id"
    t.string "name", default: "untitled"
    t.text "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "movie"
    t.string "slug"
    t.index ["slug"], name: "index_animations_on_slug"
    t.index ["user_id"], name: "index_animations_on_user_id"
  end

  create_table "animations_tags", id: false, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "animation_id", null: false
    t.index ["animation_id", "tag_id"], name: "index_animations_tags_on_animation_id_and_tag_id"
    t.index ["tag_id", "animation_id"], name: "index_animations_tags_on_tag_id_and_animation_id"
  end

  create_table "comment_votes", force: :cascade do |t|
    t.integer "value"
    t.integer "user_id"
    t.integer "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_comment_votes_on_comment_id"
    t.index ["user_id"], name: "index_comment_votes_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "animation_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animation_id"], name: "index_comments_on_animation_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "frames", force: :cascade do |t|
    t.text "color_map"
    t.integer "duration", default: 250
    t.integer "animation_id"
    t.integer "position"
    t.integer "width", default: 75
    t.integer "height", default: 48
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animation_id"], name: "index_frames_on_animation_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "description", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_tags_on_slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "handle"
    t.string "password_digest"
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "email"
    t.string "phone", default: ""
    t.text "bio", default: ""
    t.string "signature", default: ""
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["email"], name: "index_users_on_email"
    t.index ["handle"], name: "index_users_on_handle"
    t.index ["slug"], name: "index_users_on_slug"
  end

end
