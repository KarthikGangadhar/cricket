module BallbyballHelper
  def getPlayerName(ballbyball, pid)

    player_name = ""
    ballbyball['data']['team'].each do |team|
      team['player'].each do |player|
        if player['player_id'] == pid
          player_name = player['known_as']
        end
      end
    end
    return player_name

  end
end
