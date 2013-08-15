# -*- coding: utf-8 -*-
require 'tk'
require './lifegame'

# GUI版ライフゲーム本体
class TkLifeGame
  include Tk                    # Tkの機能を取り込む

  def initialize(width = 80, height = 80, rectsize = 6)
    @lifegame = LifeGame.new(width, height)
    @rectsize = rectsize

    # メインのWindow生成
    @canvas = TkCanvas.new(nil,
                           'width'  => (width - 1)  * rectsize,
                           'height' => (height - 1) * rectsize,
                           'borderwidth' => 1,
                           'relief' => 'sunken')

    # [next]ボタン生成
    @nextbutton = TkButton.new(nil, 'text' => 'next')

    # [go/stop]ボタン生成
    @gobutton = TkButton.new(nil, 'text' => 'go')

    # [quit]ボタン生成
    @quitbutton = TkButton.new(nil, 'text' => 'quit')
    @canvas.pack
    @nextbutton.pack('side' => 'left')
    @gobutton.pack('side' => 'left')
    @quitbutton.pack('side' => 'left')

    @prevgrid = {}
    @rectangles = {}
  end

  # 実行
  def run
    display
    mainloop
  end

  # 表示
  def display
    nextgrid = {}
    @lifegame.each_life {|geom|
      if @prevgrid[geom]
        @prevgrid[geom] = nil     # 生き残る点
      else
        setrect(geom)             # 生まれた点
      end
      nextgrid[geom] = true
    }
    @prevgrid.each_key {|geom|
      resetrect(geom)             # 死んだ点
    }
    @prevgrid = nextgrid
  end

  # 点の表示
  def setrect(geom)
    @rectangles[geom] = TkcRectangle.new(@canvas,
                                        geom.x * @rectsize,
                                        geom.y * @rectsize,
                                        geom.x * @rectsize + @rectsize - 2,
                                        geom.y * @rectsize + @rectsize - 2,
                                        'fill' => 'black')
  end

  # 点の消失
  def resetrect(geom)
    @rectangles[geom].destroy
    @rectangles[geom] = nil
  end
end

g = TkLifeGame.new
g.run
