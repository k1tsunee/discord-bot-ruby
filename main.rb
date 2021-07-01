require 'discordrb'
require 'discordrb/webhooks'

discordToken = 'your-token-here'

discordBotHandler = Discordrb::Commands::CommandBot.new token: discordToken, prefix: '/k1 '

discordBotHandler.command :help do |event|
  event.channel.send_embed do |embed|
    embed.title = "Commands"
    embed.colour = 0xa55dfc
    embed.description = "Bot commands!"
  
    embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "k1tsunee", url: "https://github.com/k1tsunee", icon_url: "https://i.imgur.com/D655GD6.png")
    embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "k1tsunee")
  
    embed.add_field(name: "/k1 help", value: "Shows this message")
    embed.add_field(name: "/k1 votekick", value: "Vote kick someone. Syntax:\n/k1 votekick @<user you want to vote kick>\nIt needs 3 reacts or more to vote kick someone out.")
    embed.add_field(name: "/k1 rapaz", value: "Rapaaaaaaaaaaaais.")
    embed.add_field(name: "/k1 ronaldo", value: "e brilha mto no curintia.")
    embed.add_field(name: "/k1 bruh", value: "um momento muito certificado.")
  end
end

THUMBS_UP = "\u{1f44d}"

discordBotHandler.command :votekick do |event|
  userToBeKicked = event.message.mentions[0]
  message = event.respond 'React here to kick ' + event.message.mentions[0].mention() + '!'
  message.react THUMBS_UP
  maxReact = 3

  event.user.await!(timeout: 15) do |kick_event|
  end

  howManyReacted = message.reacted_with THUMBS_UP
  puts howManyReacted.length() - 1

    if maxReact <= (howManyReacted.length() - 1)
      event.respond event.message.mentions[0].mention() + ' got kicked lol'
      event.server.kick(userToBeKicked, 'vote kicked')
    else
      event.respond 'failed to kick ' + event.message.mentions[0].mention()
    end
end

discordBotHandler.command :rapaz do |event|
  channel = event.user.voice_channel
  next "Please, connect to a voice channel" unless channel
  discordBotHandler.voice_connect(channel)
  voice_bot = event.voice
  voice_bot.play_file('soundData/rapaz.mp3')
  discordBotHandler.voice_destroy(event.server.id)
end

discordBotHandler.command :ronaldo do |event|
  channel = event.user.voice_channel
  next "Please, connect to a voice channel" unless channel
  discordBotHandler.voice_connect(channel)
  voice_bot = event.voice
  voice_bot.play_file('soundData/ronaldo.mp3')
  discordBotHandler.voice_destroy(event.server.id)
end

discordBotHandler.command :bruh do |event|
  channel = event.user.voice_channel
  next "Please, connect to a voice channel" unless channel
  discordBotHandler.voice_connect(channel)
  voice_bot = event.voice
  voice_bot.play_file('soundData/bruh.mp3')
  discordBotHandler.voice_destroy(event.server.id)
end
discordBotHandler.message(with_text: 'Majima-san') do |event|
  event.respond 'Kiryu-chan!!'
end

discordBotHandler.run
