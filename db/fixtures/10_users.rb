User.seed(:id,
          { id: Constants::Users::UNKNOWN_LEAD_ID,
            first_name: "Lead",
            last_name: "Unknown",
            team_id: Constants::Teams::UNKNOWN_ID },

          { id: Constants::Users::UNKNOWN_FOLLOW_ID,
            first_name: "Follow",
            last_name: "Unknown",
            team_id: Constants::Teams::UNKNOWN_ID }
          )
