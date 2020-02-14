namespace :data do
  task import_stops: :environment do
    Stop.delete_all
    open(Rails.root.join('data/stops.txt')) do |csv|
      line_counter = 0
      csv.each_line do |line|
        if line_counter == 0
          line_counter += 1
          next
        end
        values = line.split("\",").map(&:strip).map { |v| v.gsub("\"", "")}
        Stop.create!(
          stop_id: values[0],
          name: values[1],
          lat: values[2].to_f,
          lon: values[3].to_f,
          location_type: values[4],
          parent_station: values[5]
        )
      end
    end
  end

  task import_routes: :environment do
    Route.delete_all
    open(Rails.root.join('data/routes.txt')) do |csv|
      line_counter = 0
      csv.each_line do |line|
        if line_counter == 0
          line_counter += 1
          next
        end
        values = line.split("\",").map(&:strip).map { |v| v.gsub("\"", "")}
        Route.create!(
          route_id: values[0],
          short_name: values[2],
          long_name: values[3],
          route_type: values[4].to_i,
          color: values[5],
          text_color: values[6],
        )
      end
    end
  end

  task import_trips: :environment do
    Trip.delete_all
    open(Rails.root.join('data/trips.txt')) do |csv|
      line_counter = 0
      csv.each_line do |line|
        if line_counter == 0
          line_counter += 1
          next
        end
        values = line.split("\",").map(&:strip).map { |v| v.gsub("\"", "")}
        Trip.create!(
          trip_id: values[2],
          route_id: values[0],
          service_id: values[1],
          headsign: values[3],
          direction: values[4].to_i,
          block: values[5].to_i
        )
      end
    end
  end

  task import_transfers: :environment do
    Transfer.delete_all
    open(Rails.root.join('data/transfers.txt')) do |csv|
      line_counter = 0
      csv.each_line do |line|
        if line_counter == 0
          line_counter += 1
          next
        end
        values = line.split("\",").map(&:strip).map { |v| v.gsub("\"", "")}
        Transfer.create!(
          from_stop_id: values[0],
          to_stop_id: values[1],
          transfer_type: values[2].to_i,
          min_transfer_time: values[3].to_i,
        )
      end
    end
  end

  task import_stop_times: :environment do
    StopTime.delete_all
    open(Rails.root.join('data/stop_times.txt')) do |csv|
      line_counter = 0
      csv.each_line do |line|
        if line_counter == 0
          line_counter += 1
          next
        end
        values = line.split("\",").map(&:strip).map { |v| v.gsub("\"", "")}
        StopTime.create!(
          trip_id: values[0],
          arrival_time: values[1],
          departure_time: values[2],
          stop_id: values[3],
          stop_sequence: values[4].to_i,
          stop_headsign: values[5],
          pickup_type: values[6],
          drop_off_type: values[7]
        )
      end
    end
  end
end
