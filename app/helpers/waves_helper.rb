# app/helpers/waves_helper.rb
module WavesHelper
  def wave_icon_by_size(wave_size)
    case wave_size
    when "ヒザ～モモ"
      "wave_hiza.svg"
    when "コシ～ハラ"
      "wave_koshi.svg"
    when "ムネ～カタ"
      "wave_mune.svg"
    when "～頭"
      "wave_atama.svg"
    when "～オーバーヘッド"
      "wave_over.svg"
    else
      "wave.svg"
    end
  end
end
