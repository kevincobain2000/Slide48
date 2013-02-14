//
//  IAPuzzleBoardView.h
//  Slizzle
//
//  Created by Ikhsan Assaat on 5/10/11.
//  Copyright 2011 Beetlebox All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHUFFLE_TIMES   100     // amount of shuffling // jumlah berapa kali acak
#define BOARD_SIZE      4       // size of the board // ukuran dari 

@class IAPuzzleBoard;

@protocol IAPuzzleBoardDelegate;

@interface IAPuzzleBoardView : UIView {
    CGFloat _tileWidth;
    CGFloat _tileHeight;
    
    id <IAPuzzleBoardDelegate> _delegate;
    IAPuzzleBoard *_board;
    NSMutableArray *_tiles;
    
    UIImageView *_draggedTile;
    int _direction;
}

@property CGFloat tileWidth;
@property CGFloat tileHeight;
@property (nonatomic, assign) IBOutlet id <IAPuzzleBoardDelegate> delegate;
@property (nonatomic, retain) IAPuzzleBoard *board;
@property (nonatomic, retain) NSMutableArray *tiles;

/*
 Initialize this view with image, size of the board, and frame size in the controller. This initializer can be used when you make this using code not from IB. (image, size, frame)
 Inisialisasi view ini dengan image, ukuran papan dan ukuran frame di controller. Inisialisasi ini digunakan bila membuat dengan kode, bukan IB. (image, size, frame)
*/
- (id)initWithImage:(UIImage *)image andSize:(NSInteger)size withFrame:(CGRect)frame;

/*
 Method to start playing the puzzle. This should be used when you initiliazed the board with IB (image, size)
 Prosedur untuk memulai memainkan puzzle. Ini digunakakn ketika papan dibuat menggunakan IB. (image, size)
*/
- (void)playWithImage:(UIImage *)image andSize:(NSInteger)size;

/*
 Shuffle the board (SHUFFLE_TIMES) times, and then draw the puzzle board.
 Acak papan sebanyak SHUFFLE_TIMES kali, dan gambar papan puzzle.
*/
- (void)play;

@end

@protocol IAPuzzleBoardDelegate
/*
 This delegate method is fired when the puzzle board is finished
 Prosedur delegasi ini dipanggil bila papan tersebut telah selesai dimainkan
*/
- (void)puzzleBoardDidFinished:(IAPuzzleBoardView *)board;

/*
 This delegate method is fired when a tile is moved
 Prosedur delegasi ini dipanggil bila ada petak yang berhasil digerakkan
*/
- (void)puzzleBoard:(IAPuzzleBoardView *)board emptyTileDidMovedTo:(CGPoint)tilePoint;
@end
