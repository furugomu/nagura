# -*- encoding: UTF-8 -*-
module DojosHelper
  def link_to_dojo(text, dojo, options={})
    link_to text, battle_check_url(dojo.mbgaid), options
  end

  def imcg_user_url(mbgaid)
    imcg_url('http://125.6.169.35/idolmaster/profile/show/'+mbgaid.to_s)
  end

  def battle_check_url(mbgaid)
    imcg_url('http://125.6.169.35/idolmaster/battle/battle_check/'+mbgaid.to_s)
  end

  def short_personality(p)
    {'cute'=>'Cu', 'cool'=>'Co', 'passion'=>'Pa'}[p]
  end

  private

  def imcg_url(rawurl)
    host = if sp? then 'sp.pf.mbga.jp' else 'pf.mbga.jp' end
    q = {url: rawurl}
    q[:guid] = 'ON' if docomo_fp?
    'http://%s/12008305/?%s' % [host, q.to_query]
  end

  # スマホ？
  def sp?
    !fp?
  end

  # ガラケー？
  def fp?
    request.mobile?
  end

  # ドコモのガラケー？
  def docomo_fp?
    request.mobile.is_a?(Jpmobile::Mobile::Docomo)
  end
end
