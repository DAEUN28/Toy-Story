//
//  AudioPlayer.swift
//  AudioManager
//
//  Created by DaEun Kim on 2021/03/28.
//

import AVFoundation

final class AudioPlayer: NSObject {

  // MARK: - Properties

  private let requiredAssetKeys = ["playable"]
  private let queuePlayer: AVQueuePlayer
  private let playerLooper: AVPlayerLooper?
  private let thenStart: Bool
  private var playerItemContext = 0

  private(set)var isPlaying = false

  var volume: Float {
    didSet {
      queuePlayer.volume = volume
    }
  }
  var isMuted: Bool {
    didSet {
      queuePlayer.isMuted = isMuted
    }
  }
  var removeUponFinish: Bool

  // MARK: - Initizlie

  init(
    _ url: URL,
    volume: Float = 1,
    isMuted: Bool = false,
    isLooping: Bool = false,
    removeUponFinish: Bool = true,
    thenStart: Bool = false
  ) {
    self.volume = volume
    self.isMuted = isMuted
    // TODO: AVPlayerItemFailedToPlayToEndTime, AVPlayerItemDidPlayToEndTime 추가
    self.removeUponFinish = removeUponFinish
    self.thenStart = thenStart

    let asset = AVAsset(url: url)
    let playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: requiredAssetKeys)
    queuePlayer = AVQueuePlayer()

    if isLooping {
      playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
    } else {
      playerLooper = nil
      queuePlayer.insert(playerItem, after: nil)
    }

    super.init()

    queuePlayer.volume = volume
    queuePlayer.isMuted = isMuted
    playerItem.addObserver(self,
                           forKeyPath: #keyPath(AVPlayerItem.status),
                           options: [.old, .new],
                           context: &playerItemContext)
  }

  deinit {
    pause()
  }

  // MARK: - Playback

  func play() {
    queuePlayer.play()
    isPlaying = true
  }

  func pause() {
    queuePlayer.pause()
    isPlaying = false
  }

  // MARK: - Observing

  override func observeValue(
    forKeyPath keyPath: String?,
    of object: Any?,
    change: [NSKeyValueChangeKey : Any]?,
    context: UnsafeMutableRawPointer?
  ) {
    guard context == &playerItemContext else {
      super.observeValue(forKeyPath: keyPath,
                         of: object,
                         change: change,
                         context: context)
      return
    }

    if keyPath == #keyPath(AVPlayerItem.status) {
      let status: AVPlayerItem.Status

      if let statusNumber = change?[.newKey] as? NSNumber {
        status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
      } else {
        status = .unknown
      }

      switch status {
      case .readyToPlay: if thenStart { play() }
      case .failed: break
      case .unknown: break
      @unknown default: break
      }
    }
  }
}
