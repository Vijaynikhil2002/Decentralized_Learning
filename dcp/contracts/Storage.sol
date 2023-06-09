// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    string public name = "Storage";
    uint public fileCount = 0;

    struct File {
        uint fileId;
        string fileHash;
        uint fileSize;
        string fileType;
        string fileName;
        string fileDescription;
        uint uploadTime;
        address payable uploader;
    }

    event FileUploaded(
        uint fileId,
        string fileHash,
        uint fileSize,
        string fileType,
        string fileName,
        string fileDescription,
        uint uploadTime,
        address payable uploader
    );

    mapping(uint => File) public files;
    mapping(string => uint) public isHash;
    constructor() {}

    function uploadFile(string memory _fileHash, uint _fileSize, string memory _fileType, string memory _fileName, string memory _fileDescription) public {
        require(bytes(_fileHash).length > 0, "File hash cannot be empty");
        require(bytes(_fileType).length > 0, "File type cannot be empty");
        require(bytes(_fileDescription).length > 0, "File description cannot be empty");
        require(bytes(_fileName).length > 0, "File name cannot be empty");
        require(_fileSize > 0, "File size must be greater than 0");
        require(isHash[_fileHash] == 0, "File already existing");
        require(msg.sender != address(0), "Invalid uploader address");
        fileCount++;
        files[fileCount] = File(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, block.timestamp, payable(msg.sender));
        isHash[_fileHash] = 1;
        emit FileUploaded(fileCount, _fileHash, _fileSize, _fileType, _fileName, _fileDescription, block.timestamp, payable(msg.sender));
    }
}
