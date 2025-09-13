# Uptime

A simple website uptime tracker written in Elixir. Intended as a project to learn more about Phoenix, OTP and Elixir.

## Usage:
To create a monitor:
```
curl --request POST \
  --url http://localhost:4000/api/monitors \
  --header 'Content-Type: application/json' \
  --data '{
	"monitor": {
		"url": "https://news.ycombinator.com/"
	}
}'
```
To read the status of the monitor:
```
curl --request GET \
  --url http://localhost:4000/api/monitors/1/status

{
	"data": {
		"status": "up",
		"inserted_at": "2025-09-13T18:23:13Z"
	}
}
```

## Notes:
- All monitors run in their own `GenServer`, `MonitorWorker`. These create HTTP requests to the given `url`, and add the `status` (if the monitor is up or down) into the `monitor_status` table.
- These monitors are supervised by a `DynamicSupervisor`, `MonitorSupervisor` that ensures all the monitor's are running
- If the monitor is down, it emits a `PubSub` message on the `monitor_status` channel, which is read by the `MonitorStatusListener`.

## Future Enhancements:
- Allow the ability to start / stop the monitors via the API
- Instead of persisting every single `monitor_status`, only keep the last 100 or so
- Aggregate and render historical monitor status 

## Setup
To start your Phoenix server:

* Run `mix setup` to install and setup dependencies
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
