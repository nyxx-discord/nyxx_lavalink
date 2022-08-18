## 3.0.1
__18.8.2022__
- Bump the nyxx version to `4.0.0`

## 3.0.1
__23.1.2022__
- Fixed a bug where the `Client-Name` header was not sent

## 3.0.0
__19.12.2021__

- Implemented new interface-based entity model.
  > All concrete implementations of entities are now hidden behind interfaces which exports only behavior which is
  > intended for end developer usage. For example: User is now not exported and its interface `IUser` is available for developers.
  > This change shouldn't have impact of end developers.

Other changes are initial implementation of unit and integration tests to assure correct behavior of internal framework
processes. Also added `Makefile` with common commands that are run during development.

## 3.0.0-dev.0
__24.11.2021__

- Implemented new interface-based entity model.
  > All concrete implementations of entities are now hidden behind interfaces which exports only behavior which is
  > intended for end developer usage. For example: User is now not exported and its interface `IUser` is available for developers.
  > This change shouldn't have impact of end developers.

Other changes are initial implementation of unit and integration tests to assure correct behavior of internal framework
processes. Also added `Makefile` with common commands that are run during development.

## 2.0.0
_03.10.2021_

> Bumped version to 2.0 for compatibility with nyxx

- Initial implementation (covers 100% of lavalink API)

## 2.0.0-rc.1

- Added `TrackStuck` and `TrackException` events.
- Removed `type` property from `TrackEndEvent`
- Changed `position` property from `PlayerUpdateStateEvent` type to `int?` to avoid deserializing errors when using Andesite instead of Lavalink
- Updated `Exception` model
