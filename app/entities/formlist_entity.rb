class FormlistEntity < Grape::Entity
    expose :bot, using: FormEntity
end