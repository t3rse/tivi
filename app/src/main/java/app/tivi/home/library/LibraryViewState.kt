/*
 * Copyright 2017 Google, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package app.tivi.home.library

import android.arch.paging.PagedList
import app.tivi.data.entities.TraktUser
import app.tivi.data.resultentities.FollowedShowEntryWithShow
import app.tivi.data.resultentities.WatchedShowEntryWithShow
import app.tivi.tmdb.TmdbImageUrlProvider
import app.tivi.trakt.TraktAuthState
import com.airbnb.mvrx.MvRxState

data class LibraryViewState(
    val allowedFilters: List<LibraryFilter> = emptyList(),
    val filter: LibraryFilter = LibraryFilter.FOLLOWED,
    val tmdbImageUrlProvider: TmdbImageUrlProvider = TmdbImageUrlProvider(),
    val isLoading: Boolean = false,
    val isEmpty: Boolean = true,
    val followedShows: PagedList<FollowedShowEntryWithShow>? = null,
    val watchedShows: PagedList<WatchedShowEntryWithShow>? = null,
    val user: TraktUser? = null,
    val authState: TraktAuthState = TraktAuthState.LOGGED_OUT
) : MvRxState