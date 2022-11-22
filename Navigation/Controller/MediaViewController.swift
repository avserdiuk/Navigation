//
//  MediaViewController.swift
//  Navigation
//
//  Created by Алексей Сердюк on 21.11.2022.
//  Copyright © 2022 aserdiuk. All rights reserved.
//

import UIKit
import AVFoundation

class MediaViewController : UIViewController {

    let music = ["Queen"]
    var track = 0


    private lazy var trackImg : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "logo")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()

    private lazy var titleLable : UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()

    private lazy var playBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "play"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(play), for: .touchUpInside)
        return btn
    }()

    private lazy var stopBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "stop"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(stop), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()

    private lazy var nextBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(nextTrack), for: .touchUpInside)
        return btn
    }()

    private lazy var prevBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(prevTrack), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()

    var player = AVAudioPlayer()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Media Player"
        view.backgroundColor = .white

        view.addSubview(titleLable)
        view.addSubview(trackImg)
        view.addSubview(playBtn)
        view.addSubview(stopBtn)

        view.addSubview(prevBtn)
        view.addSubview(nextBtn)

        NSLayoutConstraint.activate([

            titleLable.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            titleLable.centerYAnchor.constraint(equalTo: super.view.centerYAnchor, constant: -50),

            trackImg.heightAnchor.constraint(equalToConstant: 150),
            trackImg.widthAnchor.constraint(equalToConstant: 150),
            trackImg.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            trackImg.centerYAnchor.constraint(equalTo: super.view.centerYAnchor, constant: -150),

            playBtn.heightAnchor.constraint(equalToConstant: 44),
            playBtn.widthAnchor.constraint(equalToConstant: 44),
            playBtn.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: -22),
            playBtn.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),

            stopBtn.heightAnchor.constraint(equalToConstant: 44),
            stopBtn.widthAnchor.constraint(equalToConstant: 44),
            stopBtn.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: 22),
            stopBtn.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),

            nextBtn.heightAnchor.constraint(equalToConstant: 70),
            nextBtn.widthAnchor.constraint(equalToConstant: 70),
            nextBtn.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: 100),
            nextBtn.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),

            prevBtn.heightAnchor.constraint(equalToConstant: 70),
            prevBtn.widthAnchor.constraint(equalToConstant: 70),
            prevBtn.centerXAnchor.constraint(equalTo: super.view.centerXAnchor, constant: -100),
            prevBtn.centerYAnchor.constraint(equalTo: super.view.centerYAnchor),
        ])


    }

    func pp(track:String){
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: track, ofType: "mp3")!))
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }

    @objc
    func play(){

        titleLable.text = music[track]
        stopBtn.isEnabled = true

        if player.isPlaying {
            player.pause()
            playBtn.setImage(UIImage(systemName: "play"), for: .normal)
        } else {
            pp(track: music[track])
            player.play()
            playBtn.setImage(UIImage(systemName: "pause"), for: .normal)
            stopBtn.isEnabled = true
        }
    }

    @objc
    func stop() {
        if player.currentTime != .zero {
            player.stop()
            player.currentTime = .zero
            stopBtn.isEnabled = false
            playBtn.setImage(UIImage(systemName: "play"), for: .normal)
            titleLable.text = ""
        }
    }

    @objc
    func nextTrack() {
        stop()
        track += 1
        play()

        prevBtn.isEnabled = true

        print(track, music.count-1)
        if track == music.count-1 {
            nextBtn.isEnabled = false
        }

    }


    @objc
    func prevTrack() {
        track = track - 1
        stop()
        play()

        nextBtn.isEnabled = true

        print(track, music.count-1)
        if track == 0 {
            prevBtn.isEnabled = false
        }
    }
}
