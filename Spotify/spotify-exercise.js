$('document').ready(function() {

    function searchArtist() {
        $(".artist-box").remove();
        $("#artistdisplay").show();
        $("#single-artist-page").hide()
        var artistQuery = "https://api.spotify.com/v1/search?type=artist&q=" + $("#artist-js").val();
        request = $.get(artistQuery, function(data) {
            displayArtist(data);
            console.log('search done');
        });
        request.fail(handleError)
    }

    function displayArtist(data) {
        var artistsArray = data.artists.items;
        artistsArray.forEach(function(current) {
            if (current.images[0]) {
                var currentImage = current.images[0].url;
            } else {
                var currentImage = "./no_image_available.jpeg"
            }
            var $div = $("<div>", {
                id: current.name.replace(/[^a-zA-Z\d:]/g, ""),
                "class": "artist-box"
            });
            $("#artistdisplay").append($div);
            $('#' + current.name.replace(/[^a-zA-Z\d:]/g, "")).append("<p>" + current.name + "</p>" + "<img src=" + currentImage + " />" + "<span>" + current.id + "</span>")
        });
    }

    function createArtistPage(artist) {
        $('.single-artist-name').html(artist.name)
        if (artist.images[0]) {
            var artistImage = artist.images[0].url;
        } else {
            var artistImage = "./no_image_available.jpeg"
        }
        var $spotifyLink = $("<a>", {
            class: "spotify-link"
        });
        $(".single-artist-extras").prepend($spotifyLink);
        $spotifyLink.attr("href", "https://open.spotify.com/artist/" + artist.id).html("Open in Spotify");
        $('.single-artist-image').attr("src", artistImage);
        // find albums
        var albumsQuery = "https://api.spotify.com/v1/artists/" + artist.id + "/albums";
        request = $.get(albumsQuery, listAlbums);
        request.fail(handleError)
    }

    function listAlbums(albums) {
        var $albumsList = $('<ul>', {id: 'albums-list'});
        $(".single-artist-extras").append($albumsList);
        albums.items.forEach(function(album) {
            // $("#albums-list").append(`<li><a href="https://open.spotify.com/album/${album.id}">${album.name}</a></li>`);
            $("#albums-list").append(`<li><a class="album-js" data-toggle="modal" data-target="#myModal" id="${album.id}">${album.name}</a></li>`);
        })
    }

    function findSongs(event) {
        var albumQuery = "https://api.spotify.com/v1/albums/" + event.currentTarget.id;
        request = $.get(albumQuery, function(album) {
            $('.modal-title').html(album.name)
        });
        request.fail(handleError);
        var songsQuery = "https://api.spotify.com/v1/albums/" + event.currentTarget.id + "/tracks";
        request = $.get(songsQuery, function(data) {
            listSongs(data);
            console.log('songs found');
        });
        request.fail(handleError)
    }

    function listSongs(songs) {
    	$('.songs-list').empty();
        songs.items.forEach(function(song) {
            $('.songs-list').append(`<li><a class="song-js" id="${song.id}" href="#">${song.name}</a></li>`);
        });
        displaySongPlayer(songs);
    }


    function exploreArtist(event) {
        emptyArtistPage();
        switchDisplays();
        var singleArtistQuery = "https://api.spotify.com/v1/artists/" + event.currentTarget.childNodes[2].textContent;
        // how do i get the span element in the prev line?
        request = $.get(singleArtistQuery, function(data) {
            createArtistPage(data);
            console.log('artist found');
        });
        request.fail(handleError)
            // $('.single-artist-name').html(event.currentTarget.id)
            // band = $('#' + event.currentTarget.id)
    }

    function displaySongPlayer(event){
        $player= $('.js-player');
        if ($player[0].paused == false){ 
            // debugger;
            $player.trigger('pause');
            $('.btn-play').removeClass('btn-paused');
        }; 
    	var flag = event.currentTarget;
    	if(flag){
    		var $id = event.currentTarget.id
    	} else {
    		var $id = event.items[0].id
    	}
           request = $.get(`https://api.spotify.com/v1/tracks/${$id}`, function(song){
           		console.log('inside the song!');
           		$('.js-player').attr("src", song.preview_url);
           		$('.player-cover').attr("src", song.album.images[0].url);
           		$('.author').html(song.artists[0].name);
           		$('.title').html(song.name);
           });
           request.fail(handleError)
    }

    function switchDisplays() {
        $("#artistdisplay").toggle();
        $("#single-artist-page").toggle()
    }

    function emptyArtistPage() {
        $("[class^='single-artist']").empty();
        // $('artist').empty();
        // $('artist').empty();
    }

    function handleError(error) {
        console.log("Error");
        console.log(error.responseText);
    }

    function playMusic(){
        	// $('.js-player').trigger(function(){
        $player= $('.js-player');
        if ($player[0].paused == false){ 
        	// debugger;
        	$player.trigger('pause');
        	$('.btn-play').removeClass('btn-paused');
        } else {
        	// debugger;
			$player.trigger('play');
			$('.btn-play').addClass('btn-paused');
        }
    }

    function stopMusic() {
        $('.js-player').trigger('stop');
        $('.btn-play').removeClass('btn-paused');
    }


    $('#artistdisplay').on('click', '.artist-box', exploreArtist);
    //NOTE TO SELF: as .artist-box does not exist when the DOM is loaded, we bind it to a lower level existing element (#artistdisplay)
    //more info here: http://stackoverflow.com/questions/12235800/refire-ready-event-after-ajax-reload
    $("#artist-s-button").on("click", searchArtist);
    $("#backToList").on("click", switchDisplays);
    $('#single-artist-page').on("click", '.album-js', findSongs);
    $('#myModal').on("click", '.song-js', displaySongPlayer);
    $('.btn-play').on("click", playMusic);
    // $("[data-dismiss='modal']").on("click", stopMusic)
});