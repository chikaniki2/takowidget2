require 'uri'
require 'net/http'

class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @posts = Post.all
    @maps = Map.all

    uri = URI('https://spla2.yuu26.com/schedule')
    api_result = Net::HTTP.get_response(uri).body.force_encoding("UTF-8")
    data = JSON.parse(api_result)['result']

    @schedules = []
    schedule_max = data['regular'].size # レギュラーの最大数をスケジュール数として用いる
    schedule_max.times do |i|
      start_time = data['regular'][i]['start'].to_time
      time_left = ((start_time - Time.current.ceil_to(60.minutes))/3600).floor # 開始までの時間
      start_time_string = start_time.strftime("%m/%d %R") #開始時間

      # モード別のルールとマップ取得
      modes = []
        ['regular','gachi','league'].each do |mode|
          mode_name = mode
          rule_name = data[mode][i]['rule']
          case data[mode][i]['rule_ex']['statink']
            when 'nawabari'
              rule_id = 1
            when 'area'
              rule_id = 2
            when 'hoko'
              rule_id = 3
            when 'yagura'
              rule_id = 4
            when 'asari'
              rule_id = 5
          end
          #マップ2種を取得
          maps = []
          2.times{ |map_index|
            map_name = data[mode][i]['maps_ex'][map_index]['name']
            map_id =  data[mode][i]['maps_ex'][map_index]['id']
            # mapsハッシュに格納
            maps << {
              map_name: map_name,
              map_id: map_id
            }
          }
          # modesハッシュに格納
          modes << {
            mode_name: mode_name,
            rule_name: rule_name,
            rule_id: rule_id,
            maps: maps
          }
        end
        # スケジュール情報として配列に格納
      @schedules << {
        time_left: time_left,
        start_time_string: start_time_string,
        modes: modes
      }
    end
  end


  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @maps = Map.all
    @rules = Rule.all
    @weapons = Weapon.all
    @map_id = params[:map]
    @rule_id = params[:rule]
    @weapon_id = params[:weapon]
  end

  def create
    @post = Post.new(def_params)
    if @post.save
      flash[:notice] = "メモを更新しました"
      redirect_to :posts
    else
      flash[:alert] = "更新に失敗しました"
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to post_path(id: @post.id)
    end
    @maps = Map.all
    @rules = Rule.all
    @weapons = Weapon.all
    @map_id = @post.map_id
    @rule_id = @post.rule_id
    @weapon_id = @post.weapon_id
  end

def update
    @post = Post.find(params[:id])
      if @post.update(def_params) 
        flash[:notice] = "メモを更新しました"
        redirect_to :posts
      else
        flash[:alert] = "更新に失敗しました"
        render "edit"
      end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "削除しました"
    redirect_to :posts
  end

  def search
    # 武器idの決定。最後に選択した武器を取得。ないならメイン武器。それでも無ければ武器IDfirstを設定。
    if not params.has_key?('weapon')
      if current_user.last_select_weapon_id.present?
        weapon = current_user.last_select_weapon_id
      elsif current_user.favorite_weapon_id.present?
        weapon = current_user.favorite_weapon_id
      else
        weapon = Weapon.first.id
      end
    else
      weapon = params[:weapon]
    end

    #最後に選択した武器を更新
    current_user.update_attribute(:last_select_weapon_id, weapon)

    # ルールが指定されていない場合はfirsIDを指定
    if not params.has_key?('rule')
      rule = Rule.first.id
    else
      rule = params[:rule]
    end

    post = Post.find_by(map_id: params[:map], rule_id: rule, weapon_id: weapon)
    if post.present?
      redirect_to edit_post_path(id: post.id)
    else
      redirect_to new_post_path(map: params[:map], rule: rule, weapon: weapon)
    end
  end

  def search_post
    @posts = Post.where(map: params[:map], rule: params[:rule], weapon: params[:weapon])
  end

  def admnpnl
    if current_user.admnflg==false
      redirect_to posts_path
    end
    @posts = Post.all
  end

  private
    def def_params
      params.require(:post).permit(:description, :user_id, :map_id, :rule_id, :weapon_id)
    end
end
