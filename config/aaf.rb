ActsAsFerret::define_index('comeonworkjerk',
 :models => {
   User  => {:fields => [:login]},
 },
 :ferret   => {
   :default_fields => [:login]
 }
)