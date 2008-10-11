ActsAsFerret::define_index('tdcoredex',
 :models => {
   User  => {:fields => [:login]},
 },
 :ferret   => {
   :default_fields => [:login]
 }
)
